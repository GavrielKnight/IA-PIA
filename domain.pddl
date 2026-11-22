(define (domain electronic-repair)

    (:requirements :strips :typing)

    (:types
        robot dispositivo ubicacion
    )
    
    (:constants
        diagnostico taller entrega - ubicacion
    )

    (:predicates
        ; Ubicacion del robot.
        (robot-en ?r - robot ?l - ubicacion)

        ; Ubicacion de los dispositivos.
        (dispositivo-en ?d - dispositivo ?l - ubicacion)

        ; Estado de los dispositivos.
        (dispositivo-sano ?d - dispositivo)

        ; Diagnostico.
        (dispositivo-diagnosticado ?d - dispositivo)
    )

    ; ACCION 1: Mover el robot.
    (:action mover-robot
        :parameters (?r - robot ?origen - ubicacion ?destino - ubicacion)

        :precondition
            (robot-en ?r ?origen)

        :effect (and
            (robot-en ?r ?destino)
            (not (robot-en ?r ?origen))
        )
    )

    ; ACCION 2: Diagnosticar dispositivo.
    (:action diagnosticar-dispositivo
        :parameters (?r - robot ?d - dispositivo)

        :precondition (and
            (robot-en ?r diagnostico)
            (dispositivo-en ?d diagnostico)
            (not (dispositivo-diagnosticado ?d))
        )

        :effect (
            dispositivo-diagnosticado ?d
        )
    )
    
    ; ACCION 3: Transportar dispositivo a diagnostico.
    (:action transportar-a-diagnostico
        :parameters (?r - robot ?d - dispositivo ?origen - ubicacion)

        :precondition (and
            (robot-en ?r ?origen)
            (dispositivo-en ?d ?origen)
            (not (dispositivo-diagnosticado ?d))
        )

        :effect (and
            (not (robot-en ?r ?origen))
            (not (dispositivo-en ?d ?origen))
            (robot-en ?r diagnostico)
            (dispositivo-en ?d diagnostico)
        )
    )

    ; ACCION 4: Transportar dispositivo a taller.
    (:action transportar-a-taller
        :parameters (?r - robot ?d - dispositivo ?origen - ubicacion)

        :precondition (and
            (robot-en ?r ?origen)
            (dispositivo-en ?d ?origen)
            (dispositivo-diagnosticado ?d)
            (not (dispositivo-sano ?d))
        )

        :effect (and
            (not (robot-en ?r ?origen))
            (not (dispositivo-en ?d ?origen))
            (robot-en ?r taller)
            (dispositivo-en ?d taller)
        )
    )
    
    ; ACCION 5: Transportar dispositivo a entrega.
    (:action transportar-a-entrega
        :parameters (?r - robot ?d - dispositivo ?origen - ubicacion)

        :precondition (and
            (robot-en ?r ?origen)
            (dispositivo-en ?d ?origen)
            (dispositivo-diagnosticado ?d)
            (dispositivo-sano ?d)
        )

        :effect (and
            (not (robot-en ?r ?origen))
            (not (dispositivo-en ?d ?origen))
            (robot-en ?r entrega)
            (dispositivo-en ?d entrega)
        )
    )

    ; ACCION 6: Reparar dispositivo dañado.
    (:action reparar-dispositivo
        :parameters (
            ?r - robot
            ?d - dispositivo
        )

        :precondition (and
            (robot-en ?r taller)
            (dispositivo-en ?d taller)
            (dispositivo-diagnosticado ?d)
        )

        :effect (
            dispositivo-sano ?d
        )
    )
)