Given("an installed OpenShift client") do
  @ocClient = system('which oc') ## Execute the command and capture STDOUT
end

When("I run `oc whoami`") do
  @username = %x{ oc whoami }  ## Execute the command and return the STDOUT
  @success = $?                ## Capture the exit status value (Should be 0 for success)
end

Then("I should see a username returned") do
  expect(@ocClient).to be true
  expect(@success).to eq(0)
  expect(@username).to match(/josphill/)
end
