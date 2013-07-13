# = Custom Fact ansible_user_key
#
# The ansible user rsa aublic key
#
Facter.add("ansible_user_key") do
  setcode do
    value = nil
    filepath = '/home/ansible/.ssh/id_rsa.pub'
    if FileTest.file?(filepath)
      begin
        value = File.read(filepath).chomp.split(/\s+/)[1]
      rescue
        value = nil
      end
    end
  value
  end
end
