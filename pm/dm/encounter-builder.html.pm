#lang pollen

@title{Encounter Builder}

@section["this is the title"]{
    this is text
    @form{

        @label[#:for "level"]{Level}
        @input[#:type "text" #:name "level"]
    }
}

@script['async]{/js/encounter-builder/index.ts}