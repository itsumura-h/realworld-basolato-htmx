import ./env
# user
import ./models/aggregates/user/creating_user/creating_user_repository_interface
import ./data_stores/repositories/user/creating_user/creating_user_repository
import ./data_stores/repositories/user/creating_user/mock_creating_user_repository


type DiContainer* = tuple
  userRepository: ICreatingUserRepository


proc newDiContainer():DiContainer =
  if APP_ENV == "test":
    return (
      userRepository: MockCreatingUserRepository.new().toInterface(),
    )
  else:
    return (
      userRepository: CreatingUserRepository.new().toInterface(),
    )

let di* = newDiContainer()
