alias ll='ls -laGh'
alias gl='git log --pretty=format:"%C(Green)%h %C(Red)[.%D.] %C(Blue)[%an] %C(Yellow)[%s] %C(Magenta)[%ad (%ar)]"'

jdk() {
        version=$1
        export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
        java -version
}
