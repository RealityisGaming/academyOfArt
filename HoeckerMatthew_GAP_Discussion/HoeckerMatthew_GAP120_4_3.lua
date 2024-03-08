require 'Karl'

function grabOutgarments()
    lookThroughCloset();
    grabShirt();
    grabshorts();
    closeCloset();
end

function grabUndergarments()
    openDessrDrawer();
    grabSocks();
    grabUnderwear();
    closeDesserDrawer();
end

function putClothesOn()
    for i = 1, 5
    do
        slideAppendagesThrough();
    end
end

function lintRemoval()
    grabLintRoller();
    while shirt_has_lint()
    do
        rollerAgainstShirt();
    end
end

function getReady()
    while not_ready()
    do
        --get clothes
        grabUndergarments();
        grabOutgarments();
        --run appendages through holes
        putClothesOn();
        -- remove lint   
        lintRemoval();
    end
end