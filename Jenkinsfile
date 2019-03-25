pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '50'))
    timeout(time: 20, unit: 'MINUTES')
  }
  agent {
    kubernetes {
      label "ruby-go-sidecars-${env.BUILD_ID}"
      defaultContainer 'jenkins-slave-ruby'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    pod-template: jenkins-slave-go-sidecars
spec:
  volumes:
  - name: projectdir
    emptyDir: {}
  - name: git-creds
    secret:
      secretName: mcc-jenkins
  containers:
  - name: jenkins-slave-golang
    image: docker-registry.default.svc:5000/labs-ci-cd/jenkins-slave-golang
    tty: true
    volumeMounts:
    - name: git-creds
      mountPath: "/etc/git-creds"
      readOnly: true
    - name: projectdir
      mountPath: /tmp/workspace
    command:
    - cat
  - name: jenkins-slave-ruby
    image: docker-registry.default.svc:5000/labs-ci-cd/jenkins-slave-ruby
    tty: true
    volumeMounts:
    - name: git-creds
      mountPath: "/etc/git-creds"
      readOnly: true
    - name: projectdir
      mountPath: /tmp/workspace
    command:
    - cat
          """
    }
  }
  environment {
    PATH = '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/home/jenkins/bin'
  }
  stages {
    stage('Install gems') {
      steps {
        container('jenkins-slave-ruby') {
          sh '''
            bundler install --path=GEMS
          '''
        }
      }
    }
    stage ('Cucumber test'){
        steps {
          container('jenkins-slave-ruby') {
            sh '''
            echo ${OPENSHIFT_BUILD_NAME}
            /usr/local/bin/generate_container_user
            cat /etc/passwd
            echo 'ssh -i /etc/git-creds/ssh-privatekey -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $*' >> ssh
            chmod +x ./ssh
            GIT_SSH='./ssh' git clone git@gitlab.com:mcc-labs/example-oc-cucumber-test.git
            '''
    //            git branch: 'master', credentialsId: 'labs-ci-cd-mcc-jenkins', url: 'git@gitlab.com:mcc-labs/example-oc-cucumber-test.git'
            }
        }
    }
    stage('Confirm git clone from Go') {
      steps {
        container('jenkins-slave-golang') {
          sh '''
          echo ${OPENSHIFT_BUILD_NAME}
          pwd
          ls
          '''
        }
      }
    }
  }
}