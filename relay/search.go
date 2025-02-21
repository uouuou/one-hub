package relay

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/spf13/viper"
	"github.com/tidwall/gjson"
	"io"
	"net/http"
	"net/url"
	"one-api/common/logger"
	"one-api/types"
	"time"
)

// SearchRes 定义搜索结果结构体
type SearchRes struct {
	Query           string `json:"query"`
	NumberOfResults int    `json:"number_of_results"`
	Results         []struct {
		Url       string      `json:"url"`
		Title     string      `json:"title"`
		Content   string      `json:"content"`
		Positions []int       `json:"positions"`
		Score     float64     `json:"score"`
		Category  string      `json:"category"`
		Thumbnail interface{} `json:"thumbnail"`
		ImgSrc    string      `json:"img_src"`
	} `json:"results"`
	Suggestions []string `json:"suggestions"`
}

// String 将搜索结果转换为字符串
func (r SearchRes) String() string {
	marshal, err := json.Marshal(r)
	if err != nil {
		return ""
	}
	return string(marshal)
}

// search 处理搜索请求
func search(request *types.ChatCompletionRequest) {
	lastMessage := request.Messages[len(request.Messages)-1].Content.(string)
	// 提取搜索关键词
	keywords, err := getSearchKeywords(lastMessage)
	if keywords != "NO" && err == nil {
		searchResults := genSearch(keywords)
		// 添加搜索结果到消息中
		newMsg := []types.ChatCompletionMessage{
			{
				Role:    "system",
				Content: "Based on genSearch results: " + searchResults,
			},
			{
				Role:    "system",
				Content: "CurrentTime :" + time.Now().Format("2006-01-02 15:04:05"),
			},
			{
				Role:    "system",
				Content: "请执行判定用户咨询的问题与搜索结果是否存在关联，如果存在关联请联系搜索结果中的内容回答用户问题，如果不存在关联请直接回答用户问题。",
			},
		}
		request.Messages = append(newMsg, request.Messages...)
	}
}

// getSearchKeywords 从用户输入中提取搜索关键词
func getSearchKeywords(content string) (string, error) {
	requestBody := map[string]interface{}{
		"model": viper.GetString("search.ai.model"),
		"response_format": map[string]string{
			"type": "text",
		},
		"messages": []map[string]string{
			{
				"role":    "system",
				"content": fmt.Sprintf("CurrentTime:%v你是一个联网搜索机器人，你需要判断下面的对话是否需要使用搜索引擎。 如果需要，请使用工具进行搜索，如果不需要，请直接返回数字0", time.Now().Format("2006-01-02 15:04:05")),
			},
			{
				"role":    "user",
				"content": content,
			},
		},
		"tools": []map[string]interface{}{
			{
				"type": "function",
				"function": map[string]interface{}{
					"name":        "search",
					"description": "Searches the web for information.\\n\\n    Args:\\n        query: keyword to search for",
					"parameters": map[string]interface{}{
						"type": "object",
						"properties": map[string]interface{}{
							"query": map[string]interface{}{
								"type": "string",
							},
						},
						"required": []string{"query"},
					},
				},
			},
		},
	}

	jsonData, err := json.Marshal(requestBody)
	if err != nil {
		logger.SysError(err.Error())
		return "", err
	}

	// 使用 API URL
	req, err := http.NewRequest("POST", viper.GetString("search.ai.url"), bytes.NewBuffer(jsonData))
	if err != nil {
		logger.SysError(err.Error())
		return "", err
	}

	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", "Bearer "+viper.GetString("search.ai.key"))

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		logger.SysError(err.Error())
		return "", err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		logger.SysError(err.Error())
		return "", err
	}

	var response types.ChatCompletionResponse
	if err := json.Unmarshal(body, &response); err != nil {
		logger.SysError(err.Error())
		return "", err
	}

	if len(response.Choices[0].Message.ToolCalls) == 0 {
		return "NO", nil
	} else if response.Choices[0].Message.ToolCalls[0].Function.Name == "search" {
		return gjson.Get(response.Choices[0].Message.ToolCalls[0].Function.Arguments, "query").String(), nil
	} else {
		return "NO", nil
	}
}

// genSearch 执行搜索操作
func genSearch(query string) string {
	searchURL := fmt.Sprintf("%v/search?q=%s&category_general=1&format=json&engines=bing,google&safesearch=2",
		viper.GetString("search.searxng"),
		url.QueryEscape(query))

	resp, err := http.Get(searchURL)
	if err != nil {
		return fmt.Sprintf(`{"error": "搜索失败: %v"}`, err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return fmt.Sprintf(`{"error": "读取响应失败: %v"}`, err)
	}
	var searchRes SearchRes
	if err := json.Unmarshal(body, &searchRes); err != nil {
		return fmt.Sprintf(`{"error": "解析响应失败: %v"}`, err)
	}
	return searchRes.String()
}
