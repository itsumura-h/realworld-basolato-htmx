import std/json
import basolato/view

proc impl(popularTags:seq[JsonNode]):Component =
  tmpli html"""
    <div id="popular-tag-list" class="tag-list" hx-swap-oob="true">
      $for tag in popularTags{
        <a class="label label-pill label-default"
          href="/tag-feed/$(tag["id"].getInt)"
          hx-get="/htmx/home/tag-feed/$(tag["tag_name"].getStr)"
          hx-target="#feed-post-preview"
          hx-push-url="/tag-feed/$(tag["tag_name"].getStr)"
        >$(tag["tag_name"].getStr)</a>
      }
    </div>
  """

proc htmlTagListView*(popularTags:seq[JsonNode]):string =
  return $impl(popularTags)
