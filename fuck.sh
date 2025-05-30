AUTHOR="悦咚 / Dark495 <flandrestudio.cn@gmail.com>"
OUTDIR='patches'
mkdir -p "$OUTDIR"

# 把日期（短格式）一起揪出来：SHA DATE
git log --author="$AUTHOR" \
        --pretty=format:'%H %ad' \
        --date=format:'%Y-%m-%d_%H.%M.%S' |
while read -r sha date; do
  git diff-tree --no-commit-id --name-only -r "$sha" |
  while read -r file; do
    dir="$OUTDIR/${date}_${sha}/$(dirname "$file")"
    mkdir -p "$dir"
    # 只要 diff
    git show -U0 "$sha" -- "$file" \
      > "$dir/$(basename "$file").patch"
  done
done