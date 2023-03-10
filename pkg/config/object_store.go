package config

type ObjectStore struct {
	Type         string `mapstructure:"type"`
	Endpoint     string `mapstructure:"endpoint"`
	RootUser     string `mapstructure:"root_user"`
	RootPassword string `mapstructure:"root_password"`
	UseSSL       bool   `mapstructure:"use_ssl"`
	BucketName   string `mapstructure:"bucket_name"`
	Location     string `mapstructure:"location"`
}
