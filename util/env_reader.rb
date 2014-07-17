require 'singleton'

class EnvReader

  include Singleton

  #Reads environemtnal variables, only if not present
  #
  # @param file [String] a file name that contains the environmental variables
  def read_env(file = '.env')
    if !ENV['ENV']
      File.open(file, "r").each_line do |line|
        a = line.chomp("\n").split('=',2)
        a[1].gsub!(/^"|"$/, '') if ['\'','"'].include?(a[1][0])
        eval "ENV['#{a[0]}']='#{a[1] || ''}'"
      end
    end
  end

end
