# user
import ./models/aggregates/user/creating_user/creating_user_repository_interface
import ./data_stores/repositories/user/creating_user/creating_user_repository

type DiContainer* = tuple
  userRepository: ICreatingUserRepository
  
proc newDiContainer():DiContainer =
  return (
    userRepository: CreatingUserRepository.new().toInterface(),
  )

let di* = newDiContainer()
