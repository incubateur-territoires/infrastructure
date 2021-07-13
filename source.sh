export SCW_CONFIG_PATH=$HOME/.config/scw/config_incubateur-territoires.yaml
export AWS_ACCESS_KEY_ID=$(cat $SCW_CONFIG_PATH | grep access_key | awk '{print $2}')
export AWS_SECRET_ACCESS_KEY=$(cat $SCW_CONFIG_PATH | grep secret_key | awk '{print $2}')