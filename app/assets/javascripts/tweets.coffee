# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', '.change_like', () ->
  id = $(this).data(id)
  type = $(this).data(type)
  console.log(id.id)
  $.ajax '/tweets/'+id.id+'/add_like/',
    type: 'POST'
    data:{
      id: id
      type: type
    }
    success:(data, jqxhr, textStatus) ->
      $('#tweets_list').html data

$(document).on 'click', '.reply_tweet', () ->
  id = $(this).data(id)
  $('.show-'+id.id).remove_class('hidden')

$(document).on 'click', '.unfollow', () ->
  id = $(this).data(id)
  $.ajax '/users/unfollow',
    type: 'get'
    data:{
      id: id
    }
    success:(data, jqxhr, textStatus) ->
      $('#tweets_list').html data

$(document).on 'click', '.follow', () ->
  id = $(this).data(id)
  $.ajax '/users/follow',
    type: 'get'
    data:{
      id: id
    }
    success:(data, jqxhr, textStatus) ->
      $('#tweets_list').html data

$(document).on 'click', '.retweet', () ->
  id = $(this).data(id)
  $.ajax '/users/retweet',
    type: 'get'
    data:{
      id: id
    }
    success:(data, jqxhr, textStatus) ->
      $('#tweets_list').html data
