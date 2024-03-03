import std/asyncdispatch
import std/json
import allographer/query_builder
import ../../../errors
from ../../../../config/database import rdb
import ../../../models/aggregates/follow_relationship/follow_relationship_repository_interface
import ../../../models/aggregates/follow_relationship/follow_relationship_entity


type FollowRelationshipRepository* = object of IFollowRelationshipRepository

proc new*(_:type FollowRelationshipRepository):FollowRelationshipRepository =
  return FollowRelationshipRepository()


method create*(self:FollowRelationshipRepository, relationship:FollowRelationship) {.async.} =
  rdb.table("user_user_map")
      .insert(%*{
        "user_id": relationship.user.id.value,
        "follower_id": relationship.follower.id.value,
      })
  .await
