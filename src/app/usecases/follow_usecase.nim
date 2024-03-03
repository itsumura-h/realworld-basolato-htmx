import std/asyncdispatch
import ../di_container
import ../models/vo/user_id
import ../models/aggregates/follow_relationship/user_entity
import ../models/aggregates/follow_relationship/follow_relationship_entity
import ../models/aggregates/follow_relationship/follow_relationship_repository_interface

type FollowUsecase* = object
  repository:IFollowRelationshipRepository

proc new*(_:type FollowUsecase):FollowUsecase =
  return FollowUsecase(
    repository: di.followRelationshipRepository
  )


proc invoke*(self:FollowUsecase, userId, followerId:string) {.async.} =
  let userId = UserId.new(userId)
  let user = User.new(userId)
  let followerId = UserId.new(followerId)
  let follower = User.new(followerId)
  let relationship = FollowRelationship.new(user, follower)
  self.repository.create(relationship).await
