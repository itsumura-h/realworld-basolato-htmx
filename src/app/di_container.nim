import ./consts
# ==================== write ====================
import ./models/aggregates/user/user_repository_interface
import ./data_stores/repositories/user/user_repository
import ./data_stores/repositories/user/mock_user_repository

# ==================== read ====================
import ./models/dto/user/user_dao_interface
import ./data_stores/dao/user/user_dao
import ./data_stores/dao/user/mock_user_dao
# global feed list
import ./models/dto/article_list/global_feed_article_list_dao_interface
import ./data_stores/dao/article_list/global_feed_article_list/global_feed_article_list_dao
import ./data_stores/dao/article_list/global_feed_article_list/mock_global_feed_article_list_dao
# global feed count
import ./models/dto/article_list/global_feed_article_count_dao_interface
import ./data_stores/dao/article_list/global_feed_article_count/global_feed_article_count_dao
import ./data_stores/dao/article_list/global_feed_article_count/mock_global_feed_article_count_dao
# tag feed list
import ./models/dto/article_list/tag_feed_article_list_dao_interface
import ./data_stores/dao/article_list/tag_feed_article_list/tag_feed_article_list_dao
import ./data_stores/dao/article_list/tag_feed_article_list/mock_tag_feed_article_list_dao
# tag feed count
import ./models/dto/article_list/tag_feed_article_count_dao_interface
import ./data_stores/dao/article_list/tag_feed_article_count/tag_feed_article_count_dao
import ./data_stores/dao/article_list/tag_feed_article_count/mock_tag_feed_article_count_dao
# tag list
import ./models/dto/tag/tag_dao_interface
import ./data_stores/dao/tag/tag_dao
import ./data_stores/dao/tag/mock_tag_dao
# article detail
import ./models/dto/article_detail/article_detail_dao_interface
import ./data_stores/dao/article_detail/article_detail_dao
import ./data_stores/dao/article_detail/mock_article_detail_dao
# comment
import ./models/dto/comment/comment_dao_interface
import ./data_stores/dao/comment/comment_dao
import ./data_stores/dao/comment/mock_comment_dao


type DiContainer* = object
# ==================== write ====================
  userRepository*: IUserRepository
# ==================== read ====================
  userDao*: IUserDao
  globalFeedArticleListDao*: IGlobalFeedArticleListDao
  globalFeedArticleCountDao*: IGlobalFeedArticleCountDao
  tagFeedArticleListDao*: ITagFeedArticleListDao
  tagFeedArticleCountDao*: ITagFeedArticleCountDao
  tagDao*: ITagDao
  articleDetailDao*: IArticleDetailDao
  commentDao*: ICommentDao
proc new(_:type DiContainer):DiContainer =
  if APP_ENV == "test":
    return DiContainer(
      # ==================== write ====================
      userRepository: MockUserRepository.new(),
      # ==================== read ====================
      userDao: MockUserDao.new(),
      globalFeedArticleListDao: MockGlobalFeedArticleListDao.new(),
      globalFeedArticleCountDao: MockGlobalFeedArticleCountDao.new(),
      tagFeedArticleListDao: MockTagFeedArticleListDao.new(),
      tagFeedArticleCountDao: MockTagFeedArticleCountDao.new(),
      tagDao: MockTagDao.new(),
      articleDetailDao: MockArticleDetailDao.new(),
      commentDao: MockCommentDao.new(),
    )
  else:
    return DiContainer(
      # ==================== write ====================
      userRepository: UserRepository.new(),
      # ==================== read ====================
      userDao: UserDao.new(),
      globalFeedArticleListDao: GlobalFeedArticleListDao.new(),
      globalFeedArticleCountDao: GlobalFeedArticleCountDao.new(),
      tagFeedArticleListDao: TagFeedArticleListDao.new(),
      tagFeedArticleCountDao: TagFeedArticleCountDao.new(),
      tagDao: TagDao.new(),
      articleDetailDao: ArticleDetailDao.new(),
      commentDao: CommentDao.new(),
    )

let di* = DiContainer.new()
