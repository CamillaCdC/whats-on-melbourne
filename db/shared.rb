require 'pg'

def run_sql(sql, args = [])
    conn = PG.connect(dbname: 'whatsonmelbourne')
    results = conn.exec_params(sql, args)
    conn.close
    results
end