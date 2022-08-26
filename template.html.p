◊(define parent-page (parent here))
◊(define page-siblings (other-siblings here))
◊(define page-children (children here))
◊(define prev-page (previous here))
◊(define next-page (next here))
 <!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        ◊when/splice[(page-title here)]{
            <title>◊(page-title here)</title>
        }
        <link rel="stylesheet" type="text/css" href="/css/styles.less" />
    </head>
    <body>

        <main>
            ◊(->html ◊doc)

            ◊when/splice[page-children]{
                <nav class="directory">
                    <header><h2>Directory</h2></header>
                    <ul>
                        ◊(cond [page-children => (lambda (children)
                                                          (->html (map dirlink
                                                                       children)))])
                    </ul>
                </nav>
            }
        </main>

        <nav class="navbox">
            <div>
                ◊when/splice[prev-page]{
                    <a class="prev-page" href='◊(rel-path (build-pollen-path (current-project-root) prev-page))'>
                        ◊(page-title prev-page)
                    </a>
                }
            </div>
            ◊(define home-path (rel-path (build-pollen-path (current-project-root) "index.html")))
            ◊(define parent-path (rel-path (build-pollen-path (current-project-root) parent-page)))
            ◊when/splice[parent-page]{
                <div><a class="home-page" href='◊|home-path|'>Home</a></div>
                ◊when/splice[(not (equal? parent-path home-path))]{
                    <div><a class="parent-page" href='◊|parent-path|'>◊(page-title parent-page)</a></div>
                }
            }
            <div>
                ◊when/splice[next-page]{
                    <a class="next-page" href='◊(rel-path (build-pollen-path (current-project-root) next-page))'>
                        ◊(page-title next-page)
                    </a>
                }
            </div>
        </nav>

        <script async type="module" src="/js/index.mjs"></script>
    </body>
</html>
