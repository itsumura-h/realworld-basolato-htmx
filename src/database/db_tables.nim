type
  Article* = object
    id*: string
    title*: string
    description*: string
    body*: string
    authorId*: string
    createdAt*: string
    updatedAt*: string

  Comment* = object
    id*: int64
    body*: string
    articleId*: string
    authorId*: string
    createdAt*: string
    updatedAt*: string

  Tag* = object
    id*: string
    name*: string

  TagArticleMap* = object
    tagId*: string
    articleId*: string

  User* = object
    id*: string
    name*: string
    email*: string
    emailVerifiedAt*: string
    password*: string
    bio*: string
    image*: string
    createdAt*: string
    updatedAt*: string

  UserArticleMap* = object
    userId*: string
    articleId*: string

  UserUserMap* = object
    userId*: string
    followerId*: string
