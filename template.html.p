<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        ◊when/splice[(page-title doc)]{
            <title>◊(page-title doc)</title>
        }
        <link
            rel="stylesheet"
            type="text/css"
            href="/node_modules/tufte-css/tufte.min.css"
        />
        <link rel="stylesheet" type="text/css" href="/css/styles.less" />
    </head>
    <body>

        <main>
            ◊(->html ◊doc)
        </main>

        <nav class="navbox">
            ◊(define page-siblings (or (other-siblings here) '()))
            ◊(define prev-page (previous here))
            ◊(define next-page (next here))
            <div>
                ◊when/splice[(member prev-page page-siblings)]{
                    <a href='◊(rel-path (build-pollen-path "pm" prev-page))'>
                        ◊(page-title prev-page)
                    </a>
                }
            </div>
            <div>
                ◊when/splice[(member next-page page-siblings)]{
                    <a href='◊(rel-path (build-pollen-path "pm" next-page))'>
                        ◊(page-title next-page)
                    </a>
                }
            </div>
        </nav>

        <script async type="module" src="/js/index.mjs"></script>
    </body>
</html>
