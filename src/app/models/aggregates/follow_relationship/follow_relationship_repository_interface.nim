import std/asyncdispatch
import interface_implements
import ./follow_relationship_entity


interfaceDefs:
  type IFollowRelationshipRepository* = object of Rootobj
    create:proc(self:IFollowRelationshipRepository, relationship:FollowRelationship):Future[void]
