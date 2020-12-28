// A generic cardboard label holder

// Copyright (C) 2020 Jeremy Bennett <www.jeremybennett.com>

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// SPDX-License-Identifier: CC-BY-SA-4.0

//! @file A rectangular label holder

use <libraries/mylib.scad>

//! @brief Thickness of the front part of the frame

FRAME_FRONT_THICKNESS = 2.0;

//! @brief Thickness of the back part of the frame

FRAME_BACK_THICKNESS = 2.0;

//! @brief Total thickness of the frame

FRAME_THICKNESS = FRAME_FRONT_THICKNESS + FRAME_BACK_THICKNESS;

//! @brief Width of the rim surrouding the screwhead in the tag

TAG_RIM = 1.0;


//! brief Front part of the label holder.

//! Complete rectangle

//! @param frame_x            Overall X dimension of the label holder including
//!                           tags.
//! @param frame_x            Overall Y dimension of the label holder.
//! @param frame_front_width  Width of the front border of the label holder.
//! @param tag_extra          Extra space in X dimension needed on each side
//!                           for the tag.

module frame_front (frame_x, frame_y, frame_front_width, tag_extra) {
     true_x = frame_x - (tag_extra * 2);
     translate (v = [tag_extra, 0, 0])
	  cube (size = [true_x, frame_front_width, FRAME_FRONT_THICKNESS],
		center = false);
     translate (v = [tag_extra, frame_y - frame_front_width, 0])
	  cube (size = [true_x, frame_front_width, FRAME_FRONT_THICKNESS],
		center = false);
     translate (v = [tag_extra, 0, 0])
	  cube (size = [frame_front_width, frame_y, FRAME_FRONT_THICKNESS],
		center = false);
     translate (v = [frame_x - tag_extra - frame_front_width, 0, 0])
	  cube (size = [frame_front_width, frame_y, FRAME_FRONT_THICKNESS],
		center = false);
}

//! brief Back part of the label holder.

//! Three sides of the rectangle, leaving one side to drop a card through.

//! @param frame_x            Overall X dimension of the label holder including
//!                           tags.
//! @param frame_x            Overall Y dimension of the label holder.
//! @param frame_back_width   Width of the back border of the label holder.
//! @param tag_extra          Extra space in X dimension needed on each side
//!                           for the tag.

module frame_back (frame_x, frame_y, frame_back_width, tag_extra) {
     true_x = frame_x - (tag_extra * 2);
     translate (v = [tag_extra, 0, FRAME_FRONT_THICKNESS])
	  cube (size = [true_x, frame_back_width, FRAME_BACK_THICKNESS],
		center = false);
     translate (v = [tag_extra, 0, FRAME_FRONT_THICKNESS])
	  cube (size = [frame_back_width, frame_y, FRAME_BACK_THICKNESS],
		center = false);
     translate (v = [frame_x - tag_extra - frame_back_width, 0,
		     FRAME_FRONT_THICKNESS])
	  cube (size = [frame_back_width, frame_y, FRAME_BACK_THICKNESS],
		center = false);
}

//! @brief Tag to hold screws for the label holder

//! @param frame_x   Overall X dimension of the label holder including tags.
//! @param frame_x   Overall Y dimension of the label holder.
//! @param tag_diam  Diameter of the tag, including its rim

module frame_tag (frame_x, frame_y, tag_diam) {
     translate (v = [tag_diam / 2, frame_y / 2, 0])
	  cylinder (r = tag_diam / 2, h = FRAME_THICKNESS,
		    $fn = tag_diam * tag_diam, center = false);
     translate (v = [frame_x - tag_diam / 2, frame_y / 2, 0])
	  cylinder (r = tag_diam / 2, h = FRAME_THICKNESS,
		    $fn = tag_diam * tag_diam, center = false);
}

//! @brief Overall frame with tags, but without screwholes

//! @param frame_x            Overall X dimension of the label holder
//!                           including tags.
//! @param frame_x            Overall Y dimension of the label holder.
//! @param frame_front_width  Width of the front border of the label holder.
//! @param frame_back_width   Width of the back border of the label holder.
//! @param tag_diam           Diameter of the tag, including its rim

module raw_frame (frame_x, frame_y, frame_front_width, frame_back_width,
		  tag_diam) {
     tag_extra = tag_diam - frame_back_width;
     frame_front (frame_x, frame_y, frame_front_width, tag_extra);
     frame_back (frame_x, frame_y, frame_back_width, tag_extra);
     frame_tag (frame_x, frame_y, tag_diam);
}

//! @brief Label holder, complete with screw tags

//! @brief Overall frame with tags, but without screwholes

//! @param frame_x            Overall X dimension of the label holder
//!                           including tags.
//! @param frame_x            Overall Y dimension of the label holder.
//! @param frame_front_width  Width of the front border of the label holder.
//! @param frame_back_width   Width of the back border of the label holder.
//! @param shank_diam         Diameter of the shank of the screw used to hold
//!                           up the label holder

module frame (frame_x, frame_y, frame_front_width, frame_back_width,
	      shank_diam) {
     tag_diam = (shank_diam + TAG_RIM) * 2;
     difference () {
	  raw_frame (frame_x, frame_y, frame_front_width, frame_back_width,
		     tag_diam);
	  translate (v = [tag_diam / 2, frame_y / 2, 0])
	       rotate (a = [0, 180, 0])
	            metric_screwhole (shank_diam);
	  translate (v = [frame_x - tag_diam / 2, frame_y / 2, 0])
	       rotate (a = [0, 180, 0])
	            metric_screwhole (shank_diam);
     }
}

frame(70.0, 32.0, 7.0, 5.0, 3.0);

