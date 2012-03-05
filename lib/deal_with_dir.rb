require 'rubygems'
require 'fileutils'
class DealWithDir
  def initialize(path)
    @path = path || `pwd`.chomp
  end

  def get_all_files(path=@path)
    Dir.entries(path)
  end

  def remove(file,bak_file=true)
    file_name = get_all_files
    if File.directory?(file)
      FileUtils.cp_r(file, file + ".bak") if bak_file # create bak_file
      FileUtils.rm_r(file)
    else
      FileUtils.cp(file, file + ".bak") if bak_file # create bak_file
      FileUtils.rm(file)
    end unless file_name.include?(file)
    puts "文件已经删除"
  end

  def remove_all_from_dir(file,path=@path)
    puts path
    filename_array = get_all_files(path).select{|n| File.directory?(path + "/" + n) && !['.', '..'].include?(n)}
    remove_dir(filename_array, file, path)
    (defined? i).nil? ? i = 1 : i = i
    filename_array.each do |dir|
      puts i
      i += 1
      remove_all_from_dir(file,path + '/' + dir)
    end
    filename_array
  end

  private
  def remove_dir(f_array, file, path)
    if f_array.include?(file)
      remove(path + "/" + file,false)
      f_array.delete(file)
    end
    f_array
  end
end

dir_path = "/Users/vitoli/to_vito/uas"
DealWithDir.new(dir_path).remove_all_from_dir('.svn')

