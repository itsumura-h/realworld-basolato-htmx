type
  ArticleTable* = object
    id*: string
    title*: string
    description*: string
    body*: string
    authorId*: string
    createdAt*: string
    updatedAt*: string

  CommentTable* = object
    id*: int64
    body*: string
    articleId*: string
    authorId*: string
    createdAt*: string
    updatedAt*: string

  TagTable* = object
    id*: string
    name*: string

  TagArticleMapTable* = object
    tagId*: string
    articleId*: string

  UserTable* = object
    id*: string
    name*: string
    email*: string
    emailVerifiedAt*: string
    password*: string
    bio*: string
    image*: string
    createdAt*: string
    updatedAt*: string

  UserArticleMapTable* = object
    userId*: string
    articleId*: string

  UserUserMapTable* = object
    userId*: string
    followerId*: string
