#!groovy

import jenkins.model.*
import hudson.security.*

def instance = Jenkins.getInstance()

println "--> creating local user 'admin'"

def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount('admin','admin123')
instance.setSecurityRealm(hudsonRealm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
instance.setAuthorizationStrategy(strategy)
instance.save()

// import jenkins.model.*
// import hudson.security.*

// def env = System.getenv()

// def jenkins = Jenkins.getInstance()
// jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))

// def user = jenkins.getSecurityRealm().createAccount('admin', 'admin123')
// user.save()

// jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, 'admin')
// jenkins.save()

