module one-api

// +heroku goVersion go1.18
go 1.23.0

toolchain go1.24.0

require (
	cloud.google.com/go/iam v1.4.0
	github.com/aliyun/aliyun-oss-go-sdk v3.0.2+incompatible
	github.com/anknown/ahocorasick v0.0.0-20190904063843-d75dbd5169c0
	github.com/aws/aws-sdk-go v1.55.6
	github.com/aws/aws-sdk-go-v2/aws/protocol/eventstream v1.6.10
	github.com/aws/smithy-go v1.22.3
	github.com/bwmarrin/snowflake v0.3.0
	github.com/coocood/freecache v1.2.4
	github.com/coreos/go-oidc/v3 v3.12.0
	github.com/eko/gocache/lib/v4 v4.2.0
	github.com/eko/gocache/store/freecache/v4 v4.2.2
	github.com/eko/gocache/store/redis/v4 v4.2.2
	github.com/gin-contrib/cors v1.7.3
	github.com/gin-contrib/gzip v1.2.2
	github.com/gin-contrib/sessions v1.0.2
	github.com/gin-contrib/static v1.1.3
	github.com/gin-gonic/gin v1.10.0
	github.com/go-co-op/gocron/v2 v2.15.0
	github.com/go-gormigrate/gormigrate/v2 v2.1.3
	github.com/go-playground/validator/v10 v10.25.0
	github.com/golang-jwt/jwt v3.2.2+incompatible
	github.com/gomarkdown/markdown v0.0.0-20250207164621-7a1f277a159e
	github.com/google/uuid v1.6.0
	github.com/gorilla/websocket v1.5.3
	github.com/mitchellh/mapstructure v1.5.0
	github.com/pkoukk/tiktoken-go v0.1.7
	github.com/prometheus/client_golang v1.21.0
	github.com/redis/go-redis/v9 v9.7.0
	github.com/samber/lo v1.49.1
	github.com/shopspring/decimal v1.4.0
	github.com/smartwalle/alipay/v3 v3.2.24
	github.com/spf13/viper v1.19.0
	github.com/sqids/sqids-go v0.4.1
	github.com/stretchr/testify v1.10.0
	github.com/stripe/stripe-go/v80 v80.2.1
	github.com/tidwall/gjson v1.18.0
	github.com/tidwall/sjson v1.2.5
	github.com/wechatpay-apiv3/wechatpay-go v0.2.20
	github.com/wneessen/go-mail v0.6.2
	go.uber.org/zap v1.27.0
	golang.org/x/crypto v0.33.0
	golang.org/x/image v0.24.0
	golang.org/x/oauth2 v0.26.0
	golang.org/x/sync v0.11.0
	google.golang.org/api v0.222.0
	google.golang.org/grpc v1.70.0
	gopkg.in/natefinch/lumberjack.v2 v2.2.1
	gorm.io/driver/mysql v1.5.7
	gorm.io/driver/postgres v1.5.11
	gorm.io/driver/sqlite v1.5.7
	gorm.io/gorm v1.25.12
)

require (
	cloud.google.com/go/auth v0.15.0 // indirect
	cloud.google.com/go/auth/oauth2adapt v0.2.7 // indirect
	cloud.google.com/go/compute/metadata v0.6.0 // indirect
	filippo.io/edwards25519 v1.1.0 // indirect
	github.com/anknown/darts v0.0.0-20151216065714-83ff685239e6 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/bytedance/sonic/loader v0.2.3 // indirect
	github.com/cloudwego/base64x v0.1.5 // indirect
	github.com/felixge/httpsnoop v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.8.0 // indirect
	github.com/go-jose/go-jose/v4 v4.0.4 // indirect
	github.com/go-logr/logr v1.4.2 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/golang/mock v1.6.0 // indirect
	github.com/google/s2a-go v0.1.9 // indirect
	github.com/googleapis/enterprise-certificate-proxy v0.3.4 // indirect
	github.com/googleapis/gax-go/v2 v2.14.1 // indirect
	github.com/hashicorp/hcl v1.0.0 // indirect
	github.com/jackc/puddle/v2 v2.2.2 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/jonboulle/clockwork v0.5.0 // indirect
	github.com/klauspost/compress v1.18.0 // indirect
	github.com/magiconair/properties v1.8.9 // indirect
	github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822 // indirect
	github.com/prometheus/client_model v0.6.1 // indirect
	github.com/prometheus/common v0.62.0 // indirect
	github.com/prometheus/procfs v0.15.1 // indirect
	github.com/robfig/cron/v3 v3.0.1 // indirect
	github.com/sagikazarmark/locafero v0.7.0 // indirect
	github.com/sagikazarmark/slog-shim v0.1.0 // indirect
	github.com/smartwalle/ncrypto v1.0.4 // indirect
	github.com/smartwalle/ngx v1.0.9 // indirect
	github.com/smartwalle/nsign v1.0.9 // indirect
	github.com/sourcegraph/conc v0.3.0 // indirect
	github.com/spf13/afero v1.12.0 // indirect
	github.com/spf13/cast v1.7.1 // indirect
	github.com/spf13/pflag v1.0.6 // indirect
	github.com/subosito/gotenv v1.6.0 // indirect
	github.com/tidwall/match v1.1.1 // indirect
	github.com/tidwall/pretty v1.2.1 // indirect
	github.com/vmihailenco/msgpack/v5 v5.4.1 // indirect
	github.com/vmihailenco/tagparser/v2 v2.0.0 // indirect
	go.opentelemetry.io/auto/sdk v1.1.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.59.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.59.0 // indirect
	go.opentelemetry.io/otel v1.34.0 // indirect
	go.opentelemetry.io/otel/metric v1.34.0 // indirect
	go.opentelemetry.io/otel/trace v1.34.0 // indirect
	go.uber.org/mock v0.5.0 // indirect
	go.uber.org/multierr v1.11.0 // indirect
	golang.org/x/exp v0.0.0-20250218142911-aa4b98e5adaa // indirect
	golang.org/x/time v0.10.0 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20250219182151-9fdb1cabc7b2 // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20250219182151-9fdb1cabc7b2 // indirect
	google.golang.org/protobuf v1.36.5 // indirect
	gopkg.in/ini.v1 v1.67.0 // indirect
)

require (
	github.com/PaulSonOfLars/gotgbot/v2 v2.0.0-rc.31
	github.com/bytedance/sonic v1.12.9 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f // indirect
	github.com/dlclark/regexp2 v1.11.5 // indirect
	github.com/gabriel-vasile/mimetype v1.4.8 // indirect
	github.com/gin-contrib/sse v1.0.0 // indirect
	github.com/go-playground/locales v0.14.1 // indirect
	github.com/go-playground/universal-translator v0.18.1 // indirect
	github.com/go-sql-driver/mysql v1.9.0 // indirect
	github.com/goccy/go-json v0.10.5 // indirect
	github.com/gorilla/context v1.1.2 // indirect
	github.com/gorilla/securecookie v1.1.2 // indirect
	github.com/gorilla/sessions v1.4.0 // indirect
	github.com/jackc/pgpassfile v1.0.0 // indirect
	github.com/jackc/pgservicefile v0.0.0-20240606120523-5a60cdf6a761 // indirect
	github.com/jackc/pgx/v5 v5.7.2 // indirect
	github.com/jinzhu/inflection v1.0.0 // indirect
	github.com/jinzhu/now v1.1.5 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/klauspost/cpuid/v2 v2.2.9 // indirect
	github.com/leodido/go-urn v1.4.0 // indirect
	github.com/mattn/go-isatty v0.0.20 // indirect
	github.com/mattn/go-sqlite3 v1.14.24 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/pelletier/go-toml/v2 v2.2.3 // indirect
	github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2 // indirect
	github.com/twitchyliquid64/golang-asm v0.15.1 // indirect
	github.com/ugorji/go/codec v1.2.12 // indirect
	golang.org/x/arch v0.14.0 // indirect
	golang.org/x/net v0.35.0
	golang.org/x/sys v0.30.0 // indirect
	golang.org/x/text v0.22.0 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
	gorm.io/datatypes v1.2.5
)
