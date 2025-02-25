Rails.application.routes.draw do
  get("/", { :controller => "misc", :action => "homepage" })

  get("/directors/youngest", { :controller => "directors", :action => "max_dob" })
  get("/directors/eldest", { :controller => "directors", :action => "min_dob" })

  get("/directors", { :controller => "directors", :action => "index" })
  get("/directors/:path_id", { :controller => "directors", :action => "show" })

  get("/movies", { :controller => "movies", :action => "index" })
  get("/movies/:path_id", { :controller => "movies", :action => "show" })
  post("/insert_movie_record", { :controller => "movies", :action => "create"})
  
  get("/actors", { :controller => "actors", :action => "index" })
  post("/actors", { :controller => "actors", :action => "create" })

  get("/actors/:path_id", { :controller => "actors", :action => "show" })
  post("/actors/:path_id", { :controller => "actors", :action => "update" })

  get("/delete_actor/:path_id", { :controller => "actors", :action => "destroy" })

  
end
