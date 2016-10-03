path     = require 'path'
gulp     = require 'gulp'
replace  = require 'gulp-replace'
notify   = require 'gulp-error-notifier'

shell    = require 'gulp-shell'
# responsive = require 'gulp-responsive'


# 
# 修改路徑來使用 Rails Sprockets path helper
# START 

# 取得 publicPath
{ publicPath } = require './package.json'

gulp.task 'resolve-url', ->
  sourcemap_pattern = /\/\*#\ssourceMappingURL.+\*\//ig
  
  assets_pattern    = ///
    url\(
      #{publicPath}
      images\/
      ([^\.]+\.(png|jpe?g|gif|svg))
    \)
  ///ig

  replace_assets_path = (_full, $1) -> "asset-url('#{$1}')"
  
  gulp.src path.join("app/assets", "stylesheets/webpack_bundle.+(css|scss)")
      .pipe notify.handleError replace(assets_pattern, replace_assets_path)
      .pipe notify.handleError replace(sourcemap_pattern, "")
      .pipe gulp.dest path.join("app/assets", "stylesheets")

# 修改路徑來使用 Rails Sprockets path helper
# END
# 

# 
# 自動化部屬
# START

# 確認所在 branch
current_branch = require('git-branch').sync()

gulp.task 'update', shell.task [
  'npm run build'
  'git add -A'
  'git commit -m "update assets"'  
]

gulp.task 'deploy', shell.task [
  "cap staging deploy BR=#{current_branch}"
]

# 自動化部屬
# END
# 

# 
# Build Responsive Image
# START

# 產生 retina list
# retina = (width) -> [{
#   width: width
# },{
#   width: width * 2
#   rename: { prefix: "2x_" }
# }]

# gulp.task 'responsive', ->
#   gulp.src 'client/lorem/*.{png,jpg}'
#     .pipe responsive
#       'demo_*.jpg': retina(1920)
#     .pipe gulp.dest 'app/assets/images/lorem'
