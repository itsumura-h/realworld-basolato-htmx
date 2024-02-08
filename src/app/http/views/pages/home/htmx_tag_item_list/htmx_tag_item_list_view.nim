import basolato/view
import ./htmx_tag_item_list_view_model


proc impl(popularTags:HtmxTagItemListViewModel):Component =
  tmpli html"""
    <div id="popular-tag-list" class="tag-list" hx-swap-oob="true">
      $for tag in popularTags.tags{
        <a class="label label-pill label-default"
          href="/tag-feed/$(tag.id)"
          hx-get="/htmx/home/tag-feed/$(tag.name)"
          hx-target="#feed-post-preview"
          hx-push-url="/tag-feed/$(tag.name)"
        >$(tag.name)</a>
      }
    </div>
  """

proc htmxTagListView*(popularTags:HtmxTagItemListViewModel):string =
  return $impl(popularTags)
