import basolato/view
import ./htmx_tag_list_view_model


proc impl(popularTags:HtmxTagListViewModel):Component =
  tmpli html"""
    <div id="popular-tag-list" class="tag-list">
      $for tag in popularTags.tags{
        <a
          class="tag-pill tag-default"
          href="/tag-feed/$(tag.id)"
          hx-push-url="/tag-feed/$(tag.name)"
          hx-get="/htmx/home/tag-feed/$(tag.name)"
          hx-target="#feed-article-preview"
        >
          $(tag.name)
        </a>
      }
    </div>
  """

proc htmxTagListView*(popularTags:HtmxTagListViewModel):Component =
  return impl(popularTags)
