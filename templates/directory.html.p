@(define page-children (children here))
@when/splice[page-children]{
    <nav class="directory">
        <ul>
            @(cond [page-children => (lambda (children)
                                                (->html (map dirlink
                                                            children)))])
        </ul>
    </nav>
}
