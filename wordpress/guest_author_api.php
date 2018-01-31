<?php
/*
Plugin Name:  Guest Author in REST API
Description:  Add Guest Author to REST API results.
Version:      0.0.1
Author:       Mac Weekly
Author URI:   https://themacweekly.com
License:      MIT
*/
use Molongui\Authorship\Includes\Guest_Author;

add_action( 'rest_api_init', function() {
    register_rest_field('post', 'guest_author', array(
        'get_callback' => function( $post_arr ) {
            $guest_author_id = get_post_meta( $post_arr['id'], '_molongui_guest_author_id', true );
            if (is_null($guest_author_id)) {
                return null;
            } else {
                $author = new Guest_Author();
                return $author->get_author_data( $guest_author_id, 'guest');
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