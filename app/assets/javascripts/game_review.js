$(document).ready(function () {
    attachListeners()
})

function attachListeners() {
    $('#see_more_games_button').click(getGames)
    $('#show_review_link').click(showReviews)
    $('#new_review').on('submit', (reviewForm))
}

class Review {
    constructor(id, title, content, score) {
        this.id = id
        this.title = title
        this.content = content
        this.score = score
    }
}

Review.prototype.render = function() {
    let html = `
    <h3>${this.title}</h3>
    <h4>${this.score}/10</h4>
    <p>content: ${this.content}</p>
    `
    return html
}

function getGames() {
    // event.preventDefault()
    $(this).hide();
    $.get(`/games.json`, function(data){
        console.log(data)
        data.map(game => {
            $('#games').append($('<br><a href="games/'+ game.id +'" class="nes-btn is-primary"><p id="links_to_games">'+ game.name +'</p>'))
        })
    })
}

function showReviews() {
    event.preventDefault()
    $(this).hide();
    let id = parseInt($("#show_review_link").attr("data-id"))
    $.get(`/games/${id}.json`, function(data){
        data.reviews.map(r => {
            let review = new Review(r.id, r.title, r.content, r.score)
            $.get(`/games/${id}/reviews/${r.id}.json`, function(data){
                let username = data.user.username
                $('#review_list_div').append(review.render() + 'written by: ' + username + `<br><p><a href="/games/${id}/reviews/${r.id}">Edit Review</a></p><br>`)
            })
        })
    })
}

function reviewForm() {
    event.preventDefault()
    let gameId = parseInt($("#show_review_form").attr("data-id"))
    const values = $(this).serialize()

    $.post(`/games/${gameId}/reviews`, values)
    .done(function(r){
        const newReview = new Review(r.id, r.title, r.content, r.score)
        $('#new_submitted_review').append(newReview.render())
        $('#remove_form_after_submission').html('')
    })
}
