 <!DOCTYPE html>
<html>
    <head>
        @(render-include "../templates/head.html.p")
    </head>
    <body>

        <main>
            @(->html @doc)

            @(render-include "../templates/directory.html.p")
        </main>

        @(render-include "../templates/navbox.html.p")

        <script async type="module" src="/js/index.mjs"></script>
    </body>
</html>
