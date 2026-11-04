pipeline {
    agent any

    environment {
        STUDENT_NAME    = 'Alibek'
        STUDENT_SURNAME = 'Konayev'
        STUDENT_GROUP   = 'IT2-2304'
        STUDENT_ID      = '38386'
        IMAGE_NAME      = 'konayev-alibek-devops'
        CONTAINER_NAME  = 'konayev-alibek-container'
    }

    options {
        timeout(time: 15, unit: 'MINUTES')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                sh '''
                    echo "Student: ${STUDENT_NAME} ${STUDENT_SURNAME}"
                    echo "Group: ${STUDENT_GROUP}"
                    echo "Student ID: ${STUDENT_ID}"
                    echo "Git commit used by Jenkins:"
                    git log -1 --format='%H %s'
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    chmod +x scripts/*.sh
                    for f in scripts/*.sh; do
                        bash -n "$f" && echo "Syntax OK: $f"
                    done
                    echo "Build stage completed"
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    test -f Konayev_Alibek_info.txt
                    grep -q "^Name: ${STUDENT_NAME}$" Konayev_Alibek_info.txt
                    grep -q "^Student ID: ${STUDENT_ID}$" Konayev_Alibek_info.txt
                    test -f Dockerfile
                    ./scripts/Konayev_Alibek_system.sh | tee system_output.txt
                    grep -q "Student information file exists." system_output.txt
                    rm -f system_output.txt
                    echo "All checks passed"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} -t ${IMAGE_NAME}:latest .
                    docker images ${IMAGE_NAME}
                '''
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f ${CONTAINER_NAME} 2>/dev/null || true
                    docker run -d --name ${CONTAINER_NAME} \
                        -e STUDENT_NAME=${STUDENT_NAME} \
                        -e STUDENT_SURNAME=${STUDENT_SURNAME} \
                        -e STUDENT_GROUP=${STUDENT_GROUP} \
                        -e STUDENT_ID=${STUDENT_ID} \
                        -p 5001:5000 \
                        ${IMAGE_NAME}:latest
                    sleep 3
                    docker ps --filter name=${CONTAINER_NAME}
                    docker logs ${CONTAINER_NAME}
                    docker exec ${CONTAINER_NAME} python -c "import urllib.request; print(urllib.request.urlopen('http://localhost:5000').read().decode())"
                '''
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully for ${STUDENT_NAME} ${STUDENT_SURNAME} (${STUDENT_GROUP}, ID ${STUDENT_ID})"
        }
        failure {
            echo 'Pipeline failed - open the red stage and read the Console Output'
        }
    }
}
