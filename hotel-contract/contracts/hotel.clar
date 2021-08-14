(define-constant ROOM_BOOKED u0)
(define-map room {room-id: uint} {rentee: (optional principal), booked: bool, price: uint, total-days: uint})
(map-insert room {room-id: u1} {rentee: none, booked: false, price: u50, total-days: u0})
(map-insert room {room-id: u2} {rentee: none, booked: false, price: u50, total-days: u0})
(map-insert room {room-id: u3} {rentee: none, booked: false, price: u50, total-days: u0})

;; (define-public (main-check (days uint) (room-num uint))
;;     (if (check-in days room-num)
;;     (err ROOM_BOOKED)
;;     (stx-transfer? (* u50 days) tx-sender (as-contract tx-sender))
;;     )
;; )

(define-public (check-in (days uint) (room-num uint))
    (let ( 
    (x (is-booked room-num))
    (y (get-price room-num))
    )

    (if x
    (err ROOM_BOOKED)
    (begin
    (unwrap! (stx-transfer? (* y days) tx-sender (as-contract tx-sender)) (err ROOM_BOOKED))
    (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days})
    (ok u1)))
    )
    ;; (asserts! (unwrap! x (err u1)) (err ROOM_BOOKED))
    ;; (stx-transfer? (* (unwrap! y (err u1)) days) tx-sender (as-contract tx-sender))
    ;; (var-set bruh u3)


    ;; (if x  
    ;; (err ROOM_BOOKED) 
    ;; (stx-transfer? (* (unwrap! (get price (map-get? room {room-id: room-num})) (err u1)) days) tx-sender (as-contract tx-sender))
    ;; )
    ;; (ok (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days}))
    ;; (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days})

    ;; (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days}) 
    ;; )
    ;; (internal days y room-num)
    ;; (stx-transfer? (* rent days) tx-sender (as-contract tx-sender))
    ;; (if x (z (* 0 y)) (z (* 1 y)))
    ;; (stx-transfer? (* z days) tx-sender (as-contract tx-sender))
    ;; (ok (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days}))
    ;; (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days})
)

(define-read-only (is-booked (room-num uint))
    (unwrap-panic (get booked (map-get? room {room-id: room-num})))
)

(define-read-only (what-is (room-num uint))
    (map-get? room {room-id: room-num})
)

(define-read-only (get-price (room-num uint))
   (unwrap-panic (get price (map-get? room {room-id: room-num})))
)

;; (define-private (internal (days uint) (rent uint) (room-num uint))
;;     (map-set room {room-id: room-num} {rentee: (some tx-sender), booked: true, price: u50, total-days: days})
;; )

;;(define-public (force-check-out)

;;)

;;(define-public (cont-stay(deposit uint))

;;)

;;(define-public (check-out)

;;)