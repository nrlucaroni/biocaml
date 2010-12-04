(** Testing programs. Only simple operations provided. More robust solutions available elsewhere for comprehensive testing. Functions taking optional argument [cout] print to [stderr] unless argument set to different value. *)

val time : ?cout:out_channel -> ('a -> 'b) -> 'a -> 'b
  (** [time f a] returns [f a] and additionally prints a message stating number of CPU seconds required to evaluate [f a]. *)
  
val sf : ?cout:out_channel -> string -> ('a -> 'b) -> 'a -> 'b
  (** [sf msg f a] returns [f a] but also prints [started msg] and [finished msg] before and after executing [f]. *)
  
val timesf : ?cout:out_channel -> string -> ('a -> 'b) -> 'a -> 'b
  (** Combines the functionality of {!time} and {!sf}. *)
  
val get_time : ('a -> 'b) -> 'a -> ('b * float)
  (** [get_time f a] returns the result of applying [f] to [a] and the amount of time required to perform the computation. *)
  
val repeat : int -> ('a -> 'b) -> ('a -> 'b)
  (** [repeat n f] returns a function that runs [f] [n] times. *)