Rails.application.routes.draw do
  root 'ppm#readme'
  get 'ppm/readme'
  get 'ppm/pjlMyTasks'
  get 'ppm/pjlFollowedTasks'
  get 'ppm/pjlMyTasks/:id' => 'ppm#pjlMyTasks'
  get 'ppm/pjlFollowedTasks/:id' => 'ppm#pjlFollowedTasks'
end
