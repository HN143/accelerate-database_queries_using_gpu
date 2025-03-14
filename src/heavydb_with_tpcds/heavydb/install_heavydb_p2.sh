curl https://releases.heavy.ai/GPG-KEY-heavyai | sudo apt-key add -


echo "use gpu free"
echo "deb https://releases.heavy.ai/os/apt/ stable cpu" \
| sudo tee /etc/apt/sources.list.d/heavyai.list

sudo apt update
sudo apt install heavyai

echo "# HEAVY.AI variable and paths
export HEAVYAI_PATH=/opt/heavyai
export HEAVYAI_BASE=/var/lib/heavyai
export HEAVYAI_LOG=$HEAVYAI_BASE/storage/log
export PATH=/opt/heavyai/bin:$PATH" \
>> ~/.bashrc
source ~/.bashrc

cd $HEAVYAI_PATH/systemd	
./install_heavy_systemd.sh

sudo systemctl enable heavydb --now
