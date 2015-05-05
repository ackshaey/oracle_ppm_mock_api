Rails.application.routes.draw do
  root 'ppm#pjlmytasks'
  get 'ppm/pjlMyTasks'
  get 'ppm/pjlFollowedTasks'
  get 'ppm/pjlMyTasks/:id' => 'ppm#pjlMyTasks'
  get 'ppm/pjlFollowedTasks/:id' => 'ppm#pjlFollowedTasks'
end
