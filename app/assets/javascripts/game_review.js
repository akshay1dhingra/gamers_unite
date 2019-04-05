$(document).ready(function () {
    attachListeners()
})

function attachListeners() {
    $('#see_more_games_button').click(getGames)
}

function getGames() {
    // event.preventDefault()
    $(this).hide();
    $.get(`/games.json`, function(data){
        console.log(data)
        data.map(game => {
            $('#games').append($('<a href="games/'+ game.id +'"><br>'+ game.name +'<br>'))
        })
    })
}