<?php
/*
Plugin Name:  The Mac Weekly REST API Extensions
Description:  Extend the REST API for The Mac Weekly's needs.
Version:      0.0.1
Author:       The Mac Weekly
Author URI:   https://themacweekly.com
License:      MIT
*/
use Molongui\Authorship\Includes\Guest_Author;

add_action( 'rest_api_init', function() {
    register_rest_field('post', 'guest_author', array(
        'get_callback' => function( $post_arr ) {
            $guest_author_id = get_post_meta( $post_arr['id'], '_molongui_guest_author_id', true );
            if ($guest_author_id == "") {
                return null;
            } else {
                $author = new Guest_Author();
                return $author->get_author_data( $guest_author_id, 'guest');
            }
        },
    ));
    register_rest_field('post', 'normal_thumbnail_url', array(
         'get_callback' => function( $post_arr ) {
            $url = get_the_post_thumbnail_url($post_arr['id'], 'thumbnail');
              if ($url == false) {
                 return null;
              } else {
                 return $url;
              }
         },
    ));
    register_rest_field('post', 'post_meta', array(
        'get_callback' => function( $post_arr ) {
            return get_post_meta( $post_arr['id']);
        },
    ));
})
?>
