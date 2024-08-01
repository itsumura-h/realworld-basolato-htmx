import std/asyncdispatch
import basolato/view


proc popularTagsTemplate*():Future[Component] {.async.} =
  tmpl"""
    <div class="sidebar">
      <p>Popular Tags</p>

      <div class="tag-list">
        <a href="/tag/programming" class="tag-pill tag-default">programming</a>
        <a href="/tag/javascript" class="tag-pill tag-default">javascript</a>
        <a href="/tag/emberjs" class="tag-pill tag-default">emberjs</a>
        <a href="/tag/angularjs" class="tag-pill tag-default">angularjs</a>
        <a href="/tag/react" class="tag-pill tag-default">react</a>
        <a href="/tag/mean" class="tag-pill tag-default">mean</a>
        <a href="/tag/node" class="tag-pill tag-default">node</a>
        <a href="/tag/rails" class="tag-pill tag-default">rails</a>
      </div>
    </div>
  """
