$(document).ready(function () {
    attachListeners()
})

function attachListeners() {
    $('#see_more_games_button').click(getGames)
    $('#show_review_link').click(showReviews)
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

function showReviews() {
    event.preventDefault()
    $(this).hide();
    let id = parseInt($("#show_review_link").attr("data-id"))
    $.get(`/games/${id}.json`, function(data){
        data.reviews.map(r => {
            let review = `<h3><a href="/games/${id}/reviews/${r.id}">${r.title}</a></h3><h4>${r.score}/10</h4><p>content: ${r.content}</p>`
            $.get(`/games/${id}/reviews/${r.id}.json`, function(data){
                let username = data.user.username
                $('#review_list_div').append(review + 'written by: ' + username)
            })
        })
    })
}
