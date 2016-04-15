# Run all the scripts

def yesno(prompt = 'Continue?', default = 'y')
    alt = 'n' if default == 'y'
    alt = 'y' if default == 'n'
    q = "#{prompt}  [#{default}]/#{alt}: "
    input = [(print q), gets.rstrip.downcase][1]
    input = default if input.empty?
    return input == 'y'
end

first_run = 'y'
first_run = 'n' if File.directory?('tmp')

run_hist = yesno("Update historical?", first_run)
run_year = yesno("Update this year?", first_run)
run_month = yesno("Update this month?", 'y')
run_nb = yesno("Update notebooks?", 'n')

exit if not yesno("Iniciar?", default = 'y')
load './vc_historical.rb' if run_hist
load './vc_this_year.rb' if run_year
load './vc_this_month.rb' if run_month
%x( python cleancsv.py )
%x( python curator.py )
%x( jupyter nbconvert --to notebook --execute A-E_AFP.ipynb ) if run_nb
%x( jupyter nbconvert --to notebook --execute ValoresCuotaAFP.ipynb ) if run_nb
yesno("Finalizado")
