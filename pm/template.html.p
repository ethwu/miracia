 <!DOCTYPE html>
<html>
    <head>
        @(render-include "../templates/head.pp")
    </head>
    <body>

        <main>
            @(->html @doc)

            @(render-include "../templates/directory.pp")
        </main>

        @(render-include "../templates/navbox.pp")

        <script async type="module" src="/js/index.mjs"></script>
    </body>
</html>
