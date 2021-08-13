(define-constant ROOM_BOOKED u0)
(define-map room {room-id: uint} {rentee: (optional principal), booked: bool, price: uint, total-days: uint})
(map-insert room {room-id: u1} {rentee: none, booked: false, price: u50, total-days: u0})
(map-insert room {room-id: u2} {rentee: none, booked: false, price: u50, total-days: u0})
(map-insert room {room-id: u3} {rentee: none, booked: false, price: u50, total-days: u0})

(define-public (check-in (days uint) (room-num uint))
   (if (unwrap! (get booked (map-get? room {room-id: room-num})) (err u1)) 
    (err ROOM_BOOKED) 
    (stx-transfer? (* (unwrap! (get price (map-get? room {room-id: room-num})) (err u1)) days) tx-sender (as-contract tx-sender))
    )

    (ok (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days}))
)

(define-read-only (is-booked (room-num uint))
    (ok (get booked (map-get? room {room-id: room-num})))
)

(define-read-only (what-is (room-num uint))
    (ok (map-get? room {room-id: room-num}))
)

;;(define-read-only (get-price (room-num uint))
;;    (ok (get price (map-get? room (tuple (room-id room-num)))))
;;)

;;(define-public (force-check-out)

;;)

;;(define-public (cont-stay(deposit uint))

;;)

;;(define-public (check-out)

;;)