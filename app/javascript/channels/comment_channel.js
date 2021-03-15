import consumer from "./consumer"

consumer.subscriptions.create("CommentChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const text= `${data.content.text}`;
    const name= `${data.user.name}`;
    const createdAt = `${data.content.created_at}`;
    const html=`
    <li class="comments_list">
    <a class="comment_user">${name}</a>  ${text}  ${createdAt}</li>`
    const comments = document.getElementById('comments');
    const newComment = document.getElementById('comment_text');
    comments.insertAdjacentHTML('afterbegin', html);
    newComment.value='';
  }
});