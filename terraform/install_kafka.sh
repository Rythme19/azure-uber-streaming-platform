#!/bin/bash
# Script pour installer Docker et Kafka sur VM Linux

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y docker.io docker-compose
sudo systemctl enable docker
sudo systemctl start docker

# Créer un dossier Kafka
mkdir -p ~/kafka && cd ~/kafka

# Télécharger Kafka
wget https://downloads.apache.org/kafka/4.1.0/kafka_2.13-4.1.0.tgz
tar -xzf kafka_2.13-4.1.0.tgz
rm kafka_2.13-4.1.0.tgz

# Ajouter Kafka au PATH
echo 'export PATH=$PATH:~/kafka/kafka_2.13-4.1.0/bin' >> ~/.bashrc
source ~/.bashrc

# Démarrer Zookeeper et Kafka
~/kafka/kafka_2.13-4.1.0/bin/zookeeper-server-start.sh -daemon ~/kafka/kafka_2.13-4.1.0/config/zookeeper.properties
sleep 10
~/kafka/kafka_2.13-4.1.0/bin/kafka-server-start.sh -daemon ~/kafka/kafka_2.13-4.1.0/config/server.properties
sleep 10

# Créer le topic uber_topic
~/kafka/kafka_2.13-4.1.0/bin/kafka-topics.sh --create --topic uber_topic --bootstrap-server localhost:9092 --partitions 4 --replication-factor 1
