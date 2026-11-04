# konayev-alibek-devops

DevOps laboratory work of **Alibek Konayev** (group IT2-2304, Student ID 38386).

Workflow: **Linux -> Git -> GitHub -> Docker -> Jenkins**

## Structure

```
konayev_alibek/
├── app/                  Python application (prints student info, tiny HTTP server)
├── scripts/              Bash scripts
├── config/               Configuration files
├── logs/                 Logs (ignored by Git)
├── backup/               Backups (ignored by Git)
├── jenkins/              Dockerfile + helper script to run Jenkins with Docker access
├── Konayev_Alibek_info.txt
├── Dockerfile
├── docker-compose.yml
└── Jenkinsfile
```

## Quick start

```bash
./scripts/Konayev_Alibek_system.sh

docker build -t konayev-alibek-devops .
docker run -d --name konayev-alibek-container -p 5000:5000 konayev-alibek-devops
docker logs konayev-alibek-container

docker compose up -d
docker compose down
```

Jenkins job name: `Konayev_Alibek_DevOps` (Pipeline script from SCM, script path `Jenkinsfile`).

## Backup

`scripts/backup.sh` creates a `.tar.gz` archive of `config/` and `logs/` in `backup/`
(the folder is ignored by Git).
