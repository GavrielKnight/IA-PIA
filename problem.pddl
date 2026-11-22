
(define (problem repair-two-devices)

    (:domain electronic-repair)

    (:objects
        robot1 - robot

        telefono radio - dispositivo
    )

    (:init
        ; Posicion inicial del robot.
        (robot-en robot1 diagnostico)

        ; Posicion inicial de los dispositivos.
        (dispositivo-en telefono diagnostico)
        (dispositivo-en radio diagnostico)

        ; Dispositivos sanos.
        (dispositivo-sano radio)
    )

    (:goal
        (and
            ; Todos los dispositivos deben estar diagnosticados, sanos y llegar a entrega.
            (dispositivo-sano telefono)
            (dispositivo-sano radio)
            
            (dispositivo-diagnosticado telefono)
            (dispositivo-diagnosticado radio)
            
            (dispositivo-en telefono entrega)
            (dispositivo-en radio entrega)
        )
    )
)
