require 'pry'
require 'ausburbs'
require 'yaml'

postcode = '3000'

Ausburbs::state("VIC").suburbs.each do |suburb| 
    if suburb.postcode == postcode 
        p suburb.name 
    end
end

binding.pry