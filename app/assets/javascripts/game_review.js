$(document).ready(function () {
    attachListeners()
})

function attachListeners() {
    $('#see_more_games_button').click(getGames)
    $('#show_review_link').click(showReviews)
    $('#show_review_form').click(reviewForm)
}

class Review {
    constructor(id, title, content, score) {
        this.id = id
        this.title = title
        this.content = content
        this.score = score
    }
    // render() {
    //     let html = `
    //     <h3>${this.title}</h3>
    //     <h4>${this.score}/10</h4>
    //     <p>content: ${this.content}</p>
    //     `
    //     return html
    // }
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
            let review = new Review(r.id, r.title, r.content, r.score)
            $.get(`/games/${id}/reviews/${r.id}.json`, function(data){
                let username = data.user.username
                $('#review_list_div').append(review.render() + 'written by: ' + username + `<p><a href="/games/${id}/reviews/${r.id}">Edit Review</a></p>`)
            })
        })
    })
}
